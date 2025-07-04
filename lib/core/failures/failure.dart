import 'package:equatable/equatable.dart';

class Failure extends Equatable{
  final StackTrace? stackTrace;
  const Failure( this.stackTrace);

  @override
  List<Object?> get props => [
    stackTrace,
  ];

}