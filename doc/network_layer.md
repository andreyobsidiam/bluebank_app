# Arquitectura de la Capa de Red con Dio y Retrofit

Este documento detalla la implementación de la capa de red en el proyecto, utilizando `dio` como cliente HTTP y `retrofit` para la generación de clientes de API type-safe.

## Stack Tecnológico

- **Dio**: Cliente HTTP robusto para realizar las peticiones.
- **Retrofit**: Generador de código para crear una implementación type-safe de nuestro cliente de API.
- **Injectable**: Para la inyección de dependencias del cliente de red.
- **Freezed**: Para la creación de modelos de datos inmutables.
- **PrettyDioLogger**: Interceptor para logging detallado de peticiones en modo debug.

## Estructura de Archivos

La capa de red reside principalmente en `lib/src/core/network/` y se estructura de la siguiente manera:

- **`dio_client.dart`**: Un `@module` de `injectable` que provee una instancia singleton de `Dio`. Aquí se configura la URL base, timeouts, y los interceptores globales como el logger.
- **`api_client.dart`**: La definición abstracta de nuestra API usando anotaciones de `retrofit`. `Injectable` se encarga de registrarla como un `@lazySingleton`.
- **`api_client.g.dart`**: Archivo generado por `retrofit` que contiene la implementación concreta del `ApiClient`. **No debe ser modificado manualmente.**

## Flujo de una Petición

El flujo para realizar una petición a la API sigue los principios de Clean Architecture:

1.  **Capa de Presentación (UI/BLoC)**: Solicita datos a un `UseCase`.
2.  **Capa de Dominio (`UseCase`)**: Llama a un método del `Repository` abstracto.
3.  **Capa de Datos (`RepositoryImpl`)**: Implementa el `Repository` y delega la llamada a un `RemoteDataSource`.
4.  **Capa de Datos (`RemoteDataSource`)**: Utiliza el `ApiClient` (inyectado) para realizar la petición de red real.
5.  **Capa Core (`ApiClient` y `Dio`)**: `Retrofit` y `Dio` se encargan de construir, ejecutar y procesar la petición HTTP. La respuesta JSON es deserializada automáticamente a un modelo de `freezed`.

## ¿Cómo agregar un nuevo endpoint?

1.  **Definir el Modelo (si es necesario)**:

    - Crea una nueva clase con `freezed` en la capa de `domain/entities` de la feature correspondiente.
    - Asegúrate de incluir el `factory` `fromJson`.

2.  **Agregar el método en `api_client.dart`**:

    - Abre `lib/src/core/network/api_client.dart`.
    - Añade un nuevo método abstracto con la anotación de `retrofit` correspondiente (`@GET`, `@POST`, etc.), especificando el path y los parámetros.

    ```dart
    @GET('/users/{id}')
    Future<User> getUserById(@Path('id') String id);
    ```

3.  **Regenerar el código**:

    - Ejecuta el comando:
      ```bash
      flutter pub run build_runner build --delete-conflicting-outputs
      ```

4.  **Implementar en el `DataSource`**:

    - Añade el nuevo método a la interfaz abstracta del `RemoteDataSource`.
    - Implementa el método en `RemoteDataSourceImpl`, llamando al nuevo método del `ApiClient`.

5.  **Implementar en el `Repository`**:
    - Sigue el mismo patrón, añadiendo el método a la interfaz del `Repository` y luego implementándolo en `RepositoryImpl` para que llame al `DataSource`.

Este enfoque asegura que la capa de red sea robusta, mantenible y fácil de extender, manteniendo un código limpio y desacoplado.
