import 'package:moloch_app/domain/core/metadata_model.dart';

class MetadataService {
  static final MetadataService _instance = MetadataService._internal();

  factory MetadataService() => _instance;

  MetadataService._internal();

  MetadataModel? _metadata;

  MetadataModel? get metadata => _metadata;

  void setMetadata(MetadataModel metadata) {
    _metadata = metadata;
  }
}