// Model untuk menampung form feedback
class FormFeedback {
  String? nama;
  String? email;
  String? feedback;

  FormFeedback({this.nama, this.email, this.feedback});

  // method untuk format URL-encoded
  String toParams() {
    return 'nama=${Uri.encodeComponent(nama ?? "")}'
           '&email=${Uri.encodeComponent(email ?? "")}'
           '&message=${Uri.encodeComponent(feedback ?? "")}';
  }
}
