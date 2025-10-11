import '../../../data/models/my_detail_model.dart';

abstract class MyDetailEvent {}

class LoadMyDetail extends MyDetailEvent {}

class UpdateMyDetail extends MyDetailEvent {
  final MyDetail myDetail;

  UpdateMyDetail(this.myDetail);
}

class DeleteMyDetail extends MyDetailEvent {}