import 'package:moloch_app/domain/core/metadata_service.dart';


extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> addMetadata() {
    var metadataService = MetadataService();
    this['metadatos'] = metadataService.metadata?.toJsonString();  
    return this;
  }
}

