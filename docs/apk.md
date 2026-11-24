# Geração do Arquivo APK

O APK do AgroVende foi gerado pelo próprio **Flutter**, que compila o código Dart para Android utilizando o Android SDK instalado junto com o Android Studio.

## Ambiente de desenvolvimento

- Flutter 3.50.1
- Dart 3.14.0
- Android Studio
- Visual Studio Code
- Android SDK

## Passo a passo

**1. Acessar a pasta do projeto:**

```bash
cd meu_agro_venda
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

## Testes

O aplicativo foi compilado, instalado e testado no emulador Android, incluindo testes de cadastro de clientes e produtos.

## Instalação

O arquivo APK pode ser instalado diretamente em celulares Android compatíveis. É necessário permitir a instalação de fontes desconhecidas, caso solicitado pelo dispositivo.

## Download do APK

O arquivo está disponível na seção Releases do GitHub.

[Baixar AgroVende.apk](https://github.com/corceteemilly-glitch/Projeto-Integrador-UCS/releases)

**Dados de acesso:**

- Usuário: admin
- Senha: 123456

Referência: https://docs.flutter.dev/deployment/android
