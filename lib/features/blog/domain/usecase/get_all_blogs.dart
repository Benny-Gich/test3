import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/features/blog/domain/entities/blog.dart';
import 'package:test3/features/blog/domain/repositories/blog_repository.dart';

@LazySingleton()
class GetAllBlogs implements UseCase<List<Blog>, Params> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(Params params) async {
    return await blogRepository.getAllBlogs();
  }
}
