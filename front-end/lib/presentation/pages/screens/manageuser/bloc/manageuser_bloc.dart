import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
part 'manageuser_event.dart';
part 'manageuser_state.dart';

class ManageuserBloc extends Bloc<ManageuserEvent, ManageuserState> {
  final ProfileRepository profileRepository;
  final TutorialBloc tutorialBloc;
  ManageuserBloc(this.profileRepository, this.tutorialBloc)
      : super(ManageUserScreenState()) {
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
    on<DeleteUserEvent>(
      (event, emit) async {
        emit(ManageuserLoading());
        final res = await profileRepository.deleteUser(event.username);
        add(GotoManageUserScreenEvent());
        if (res) {
          tutorialBloc.add(GotoManageUserEvent(1));
        }
      },
    );
  }
}
