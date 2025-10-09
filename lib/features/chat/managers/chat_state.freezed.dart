// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

  Status get status; List<Map<String, dynamic>> get messages;
  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages));
  }


  @override
  int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(messages));

  @override
  String toString() {
    return 'ChatState(status: $status, messages: $messages)';
  }


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
  @useResult
  $Res call({
    Status status, List<Map<String, dynamic>> messages
  });




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? messages = null,}) {
    return _then(_self.copyWith(
      status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
      as Status,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
    as List<Map<String, dynamic>>,
    ));
  }

}


/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({required this.status, required final  List<Map<String, dynamic>> messages}): _messages = messages;


  @override final  Status status;
  final  List<Map<String, dynamic>> _messages;
  @override List<Map<String, dynamic>> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }


  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages));
  }


  @override
  int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_messages));

  @override
  String toString() {
    return 'ChatState(status: $status, messages: $messages)';
  }


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
  @override @useResult
  $Res call({
    Status status, List<Map<String, dynamic>> messages
  });




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? messages = null,}) {
    return _then(_ChatState(
      status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
      as Status,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
    as List<Map<String, dynamic>>,
    ));
  }


}

// dart format on
