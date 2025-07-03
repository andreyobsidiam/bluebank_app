# Inyección de Dependencias con get_it e injectable

## ¿Por qué se eligió esta combinación?

Para este proyecto, se ha optado por utilizar el localizador de servicios (Service Locator) `get_it` en combinación con el generador de código `injectable`. Esta dupla es una de las soluciones más robustas y populares en el ecosistema de Flutter por las siguientes razones:

1.  **Desacoplamiento del `BuildContext`**: `get_it` no depende del árbol de widgets de Flutter. Esto significa que puedes acceder a tus dependencias (como servicios de API, repositorios de datos, etc.) desde cualquier capa de tu aplicación (lógica de negocio, acceso a datos) sin necesidad de pasar el `BuildContext`.
2.  **Reducción de código repetitivo (Boilerplate)**: `injectable` automatiza el tedioso proceso de registrar manualmente cada una de tus dependencias en el contenedor de `get_it`. Simplemente anotas tus clases y `injectable` se encarga del resto, manteniendo el código de configuración limpio y conciso.
3.  **Escalabilidad y Mantenimiento**: A medida que el proyecto crece, la gestión de dependencias se vuelve más compleja. La automatización de `injectable` y la flexibilidad de `get_it` facilitan la adición de nuevas dependencias y la refactorización del código, haciendo que el proyecto sea más fácil de mantener a largo plazo.
4.  **Soporte para Entornos**: `injectable` permite registrar diferentes implementaciones de una misma dependencia para distintos entornos (desarrollo, pruebas, producción), lo cual es fundamental para crear pruebas unitarias y de integración efectivas.

## ¿Cómo funciona?

El flujo de trabajo para la inyección de dependencias en este proyecto es el siguiente:

### 1. Definición y Anotación de Dependencias

Cuando creas una clase que quieres que sea inyectable (por ejemplo, un repositorio), la anotas con una de las directivas de `injectable`, como `@lazySingleton`, `@injectable`, o `@factoryMethod`.

**Ejemplo de un Repositorio:**

```dart
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  // ... implementación del repositorio
  @override
  Future<void> login(String email, String password) async {
    // Lógica para iniciar sesión
  }
}
```

### 2. Generación de Código

Una vez que has anotado tus clases, ejecutas el siguiente comando en la terminal:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Este comando invoca a `build_runner` y a `injectable_generator`, los cuales escanean tu código en busca de anotaciones y generan automáticamente el archivo `lib/src/core/di/injector.config.dart`. Este archivo contiene toda la lógica necesaria para registrar las dependencias en `get_it`.

### 3. Inicialización

En el punto de entrada de la aplicación (`lib/main.dart`), se realiza una llamada al método `setupInjector()` antes de que la aplicación se inicie.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector(); // Configura todas las dependencias
  runApp(const MyApp());
}
```

Este método, a su vez, llama a la función generada `$initGetIt(getIt)`, que se encarga de realizar todos los registros.

### 4. Acceso a las Dependencias

Para obtener una instancia de una dependencia registrada, simplemente usas el localizador de servicios `getIt`.

**Ejemplo en un BLoC o ViewModel:**

```dart
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/features/auth/domain/repositories/auth_repository.dart';

class AuthBloc {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  void performLogin() {
    _authRepository.login('user@example.com', 'password');
  }
}
```

De esta manera, `get_it` provee la instancia correcta del `AuthRepository` sin que el `AuthBloc` necesite saber cómo se construye.
