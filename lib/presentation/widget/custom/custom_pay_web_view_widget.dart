import 'dart:convert';
import 'package:moloch_app/domain/core/process_message_model.dart';
import 'package:moloch_app/infrastructure/utils/platform_view_registry.dart';
import 'package:moloch_app/presentation/utils/native_work_utils.dart'
    if (dart.library.html) 'dart:html'
    as html;
import 'package:moloch_app/presentation/widget/native_work.dart'
    if (dart.library.html) 'package:flutter/material.dart'
    as material
    show HtmlElementView;
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPayWebViewWidget extends StatefulWidget {
  final String webViewUrl;
  final VoidCallback success;
  final Function(String) error;
  final bool hasDialog;

  const CustomPayWebViewWidget({
    super.key,
    required this.webViewUrl,
    required this.success,
    required this.error,
    this.hasDialog = false,
  });

  @override
  State<CustomPayWebViewWidget> createState() => _CustomPayWebViewWidgetState();
}

class _CustomPayWebViewWidgetState extends State<CustomPayWebViewWidget> {
  late WebViewController controller;

  bool didFinish = false;

  @override
  void initState() {
    //PermissionUtils().getAllPermission();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_callback);
  }

  @override
  Widget build(BuildContext context) {
    return didFinish
        ? kIsWeb
            ? const material.HtmlElementView(viewType: 'XpressID-iframe')
            : WebViewWidget(controller: controller)
        : const Center(child: CircularProgressIndicator.adaptive());
  }

  void _initWeb(String urlWebView) {
    platformViewRegistry.registerViewFactory('XpressID-iframe', (int viewId) {
      final iFrame =
          html.IFrameElement()
            ..id = 'XpressID-iframe'
            ..allow = 'camera; microphone; geolocation;'
            ..src = urlWebView;
      html.window.onMessage.listen(_onMessage);
      return iFrame;
    });

    didFinish = true;
    setState(() {});
    return;
  }

  NavigationDelegate _delegate(WebViewController _controller) {
    return NavigationDelegate(
      onPageFinished: (url) {
        _controller.runJavaScript('''
            (function() {
              adjustIframeDimensions();
              window.addEventListener("message", receiveMessage, false);
              function receiveMessage(event) {
                // Mensajes recibidos desde el iframe
                if (event.origin.includes("xpressid")) {
                  var dataFromXpressID = event.data;
                  if (dataFromXpressID.code == "ProcessCompleted") {
                    const message = createMessage('ProcessCompleted', event.data);
                    ProcessStatus.postMessage(message);
                  }
                  else if (event.data.code == "ProcessCancelled") {
                    const message = createMessage('ProcessCancelled', event.data);
                    ProcessStatus.postMessage(message);
                  }
                  else if (event.data.code == "ProcessSigned") {
                    const message = createMessage('ProcessSigned', event.data);
                    ProcessStatus.postMessage(message);
                  }
                  else if (event.data.code == "ProcessSignatureRejected") {
                    const message = createMessage('ProcessSignatureRejected', event.data);
                    ProcessStatus.postMessage(message);
                  }
                  else if (event.data.code == "ProcessEvents") {
                    const message = createMessage('ProcessEvents', event.data);
                    ProcessStatus.postMessage(message);
                  }
                  else if(event.data.type == "error") {
                    const message = createMessage('error', event.data);
                    ProcessStatus.postMessage(message);
                  }
                }
              }
              
              function adjustIframeDimensions() {
                var browser = navigator.userAgent.toLowerCase();
                if (browser.indexOf('safari') > -1 && browser.indexOf('mobile') > -1) {
                  document.getElementsByTagName('html')[0].style.height = '100vh';
                  setTimeout(() => {
                    document.getElementsByTagName('html')[0].style.height = '100%';
                  }, 500);
                }
              }
              
              function createMessage(message, eventData) {
                return JSON.stringify({
                  message: message,
                  extraData: eventData,
                });
              }
            })();
          ''');
      },
      onNavigationRequest: (request) {
        if (request.url.contains('pasarela/generate_reference_oxxo')) {
          _openPdfExternally(request.url);
          return NavigationDecision.prevent;
        }
        if (request.url.contains('pasarela/generate_reference_openpay')) {
          _openPdfExternally(request.url);
          return NavigationDecision.prevent;
        }
        if (request.url.contains('pasarela/generate_clabe_conekta')) {
          _openPdfExternally(request.url);
          return NavigationDecision.prevent;
        }
        if (request.url.startsWith('https://internet.moloch.mx/')) {
          widget.success.call();
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _onMessage(html.MessageEvent event) {
    final data = event.data;
    final encode = jsonEncode(data);
    final decode = jsonDecode(encode);
    final process = ProcessMessageModel.fromJsonWeb(decode);
    _case(process);
  }

  void _case(ProcessMessageModel process) async {
    try {
      var parameters = process.toJson();
      /* switch (process.type) {
        case Kyc_status_type.completed:
          _analytics.logEvent(
            EventType.kycCompleted.value,
            parameters: parameters,
          );
          if (widget.hasDialog) AutoRouter.of(context).maybePop(true);
          widget.success.call();
          break;
        case Kyc_status_type.canceled:
          _analytics.logEvent(
            EventType.kycCanceled.value,
            parameters: parameters,
          );
          widget.error.call('');
          break;
        case Kyc_status_type.error:
          var kycError = EventType.kycError.value;
          var reason = process.extraData.message;

          _crashlytics.logEvent(name: kycError);
          await _crashlytics.registerError(
            message: kycError,
            reason: reason,
          );
          _analytics.logEvent(
            kycError,
            parameters: parameters,
          );
          widget.error.call(reason);
          break;
        case Kyc_status_type.processEvents:
          _analytics.logEvent(
            EventType.kycProcess.value,
            parameters: parameters,
          );
          break;
        default:
          if (widget.hasDialog) AutoRouter.of(context).maybePop(false);
      } */
    } catch (_e) {}
  }

  void _onMessageReceived(JavaScriptMessage data) {
    var json = jsonDecode(data.message);
    final process = ProcessMessageModel.fromJson(json);
    _case(process);
  }

  void _callback(Duration timeStamp) {
    final urlWebView = '${widget.webViewUrl}';

    if (kIsWeb) _initWeb(urlWebView);
    controller = _getController();

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(Colors.white);
    controller.loadRequest(Uri.parse(urlWebView));
    controller.setNavigationDelegate(_delegate(controller));
    controller.addJavaScriptChannel(
      'ProcessStatus',
      onMessageReceived: _onMessageReceived,
    );
    didFinish = true;
    setState(() {});
  }

  WebViewController _getController() {
    if (UniversalPlatform.isIOS) {
      PlatformWebViewControllerCreationParams params =
          WebKitWebViewControllerCreationParams(
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
          );

      return WebViewController.fromPlatformCreationParams(
        params,
        onPermissionRequest: (resources) async {
          return resources.grant();
        },
      );
    }
    return WebViewController(
      onPermissionRequest: (request) {
        request.grant();
      },
    );
  }

void _openPdfExternally(String url) async {
  try {
    final uri = Uri.parse(url);

    // Forzar la apertura en el navegador predeterminado
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    // Manejar errores de formato de URL o problemas inesperados
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al intentar abrir el enlace: $e')),
    );
  }
}
}
