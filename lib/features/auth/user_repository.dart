abstract class UserRepository { 

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> signUp(String email, String password);

  Future<void> ressetPassword(String email);


}