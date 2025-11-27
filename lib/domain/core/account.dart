class Account {
  final String cliente;
  final String nombre;
  final String phone;
  final String token;
  final String? alias;

  Account({
    required this.cliente,
    required this.nombre,
    required this.phone,
    required this.token,
    this.alias
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      cliente: json['cliente'],
      nombre: json['nombre'],
      phone: json['phone'],
      token: json['token'],
      alias: json['alias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cliente': cliente,
      'nombre': nombre,
      'phone': phone,
      'token': token,
      'alias': alias,
    };
  }
}