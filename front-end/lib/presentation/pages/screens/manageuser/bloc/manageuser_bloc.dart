import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
part 'manageuser_event.dart';
part 'manageuser_state.dart';

class ManageuserBloc extends Bloc<ManageuserEvent, ManageuserState> {
  final profileRepository;
  ManageuserBloc(this.profileRepository) : super(ManageUserScreenState()) {
    on<GotoManageUserScreenEvent>((event, emit) async {
      // emit(ManageuserInitial());
      emit(ManageUserLoading());
      print(state);
      final userList = await profileRepository.getAllUsers();
      print(userList);
      final newState = ManageUserScreenState();
      newState.userList = userList;
      emit(newState);
    });
    // on<GotoManageUserScreenEvent>(
    //  (event, emit) async {
    //    emit(ManageuserLoading());
    //    final userList = await ProfileRepository.getAllUsers();
    //    emit(ManageuserLoaded(userList));
    //  }, 
    // );
  }
}
