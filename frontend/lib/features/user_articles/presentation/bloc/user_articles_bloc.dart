import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_articles_usecase.dart';
import '../../domain/entities/user_article_entity.dart';
import 'user_articles_event.dart';
import 'user_articles_state.dart';

class UserArticlesBloc extends Bloc<UserArticlesEvent, UserArticlesState> {
  final GetUserArticlesUseCase getUserArticlesUseCase;

  UserArticlesBloc(this.getUserArticlesUseCase)
      : super(UserArticlesInitialState()) {
    // ====== CARGAR ARTÍCULOS ======
    on<GetUserArticlesEvent>((event, emit) async {
      emit(UserArticlesLoadingState());

      try {
        final List<UserArticleEntity> articles =
            await getUserArticlesUseCase();

        emit(UserArticlesLoadedState(articles));
      } catch (e) {
        emit(UserArticlesErrorState("Error al obtener artículos: $e"));
      }
    });

    // ====== CREAR ARTÍCULO ======
    on<CreateUserArticleEvent>((event, emit) async {
      emit(UserArticlesLoadingState());

      try {
        // TODO

        await Future.delayed(const Duration(seconds: 1));

        final List<UserArticleEntity> articles =
            await getUserArticlesUseCase();

        emit(UserArticlesLoadedState(articles));
      } catch (e) {
        emit(UserArticlesErrorState("Error al crear artículo: $e"));
      }
    });
  }
}
