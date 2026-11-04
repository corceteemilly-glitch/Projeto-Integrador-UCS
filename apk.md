# Geração do Arquivo APK

O APK do AgroVende será gerado pelo próprio **Flutter**, que compila o código Dart para Android usando o Android SDK instalado junto com o Android Studio.

## Passo a passo

**1. Criar o projeto:**

```bash
flutter create agrovende
```

**2. Baixar as dependências do `pubspec.yaml`:**

```bash
flutter pub get
```

**3. Gerar o APK de release:**

```bash
flutter build apk --release
```

**4. Arquivo gerado em:**

```
build/app/outputs/flutter-apk/app-release.apk
```

Esse arquivo pode ser instalado diretamente em qualquer celular Android (é necessário permitir a instalação de fontes desconhecidas, já que o app não vem da Play Store).

Referência: https://docs.flutter.dev/deployment/android
