import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/product.dart';

class EmployeeService {
  static const String url = 'https://dummyjson.com/users';

  static Future<Employee> fetchEmployeeData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Employee.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load employee data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Catching any exception that may occur (e.g., network errors)
      throw Exception('Error fetching employee data: $error');
    }
  }
}
