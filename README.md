# Bluebank App

Aplicación de home banking desarrollada con Flutter, siguiendo los principios de Clean Architecture.

## Tecnologías y Librerías

- **Lenguaje**: Dart
- **Framework**: Flutter
- **Manejo de Estado**: `flutter_bloc`
- **Navegación**: `go_router`
- **Internacionalización**: `intl`
- **Modelos Inmutables**: `freezed`
- **Inyección de Dependencias**: Por configurar (ej. `get_it`)

## Estructura del Proyecto

El proyecto sigue una estructura basada en Clean Architecture, separando el código por capas y funcionalidades.

```
lib/
├── src/
│   ├── core/
│   │   ├── config/
│   │   │   ├── router/    # Configuración de go_router
│   │   │   └── theme/     # Tema de la aplicación
│   │   ├── di/            # Inyección de dependencias
│   │   ├── l10n/          # Archivos de internacionalización
│   │   ├── services/      # Servicios (ej. notificaciones, etc.)
│   │   ├── usecases/      # Casos de uso
│   │   ├── common/
│   │   │   ├── widgets/   # Widgets reutilizables
│   │   │   └── utils/     # Utilidades
│   │   └── ...
│   ├── features/
│   │   └── auth/
│   │       ├── data/
│   │       │   ├── datasources/ # Fuentes de datos (API, local, etc.)
│   │       │   ├── models/      # Modelos de datos (DTOs)
│   │       │   └── repositories/ # Implementación de los repositorios
│   │       ├── domain/
│   │       │   ├── entities/    # Entidades de negocio
│   │       │   └── repositories/ # Abstracciones de los repositorios
│   │       └── presentation/
│   │           ├── bloc/        # BLoCs de la funcionalidad
│   │           ├── pages/       # Páginas de la funcionalidad
│   │           └── widgets/     # Widgets específicos de la funcionalidad
│   └── ...
└── main.dart              # Punto de entrada de la aplicación
```

## Próximos Pasos

1.  **Configurar Inyección de Dependencias**: Implementar la inyección de dependencias en `lib/src/core/di/injector.dart`.
2.  **Desarrollar el BLoC de Autenticación**: Crear el BLoC para manejar la lógica de negocio del inicio de sesión.
3.  **Implementar Repositorios y Fuentes de Datos**: Conectar la aplicación a una API (real o mock) para la autenticación.
4.  **Construir la Interfaz de Usuario**: Mejorar la interfaz de usuario de la página de inicio de sesión y desarrollar las demás pantallas.
