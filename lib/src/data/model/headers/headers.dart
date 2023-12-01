class LearningHeaders {
  final String token;

  const LearningHeaders({required this.token});

  Map<String, dynamic> toJson()=>{
    "x-api-token":token
  };
  
}