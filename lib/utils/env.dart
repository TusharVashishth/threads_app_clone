import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final supabaseUrl = dotenv.env["SUPABASE_URL"]!;
  static final supabaseKey = dotenv.env["SUPABASE_KEY"]!;
  static final s3Bucket = dotenv.env["S3_BUCKET"]!;
}
