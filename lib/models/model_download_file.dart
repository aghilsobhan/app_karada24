class ModelDownloadFile {
  ModelDownloadFile({
    this.fileId,
  });
  int? fileId;
  Map<String, dynamic> toJson() => {
    "fileId": fileId,
  };
}