# Instruções para executar o AgroVende

## 1. Pré-requisitos

- Flutter SDK;
- Android Studio com Android SDK;
- Git;
- Emulador Android ou dispositivo Android físico.

## 2. Baixar o projeto

Clone o repositório utilizando o comando:

```bash
git clone https://github.com/corceteemilly-glitch/Projeto-Integrador-UCS.git
```

Acesse a pasta do aplicativo:

```bash
cd Projeto-Integrador-UCS/meu_agro_venda
```

## 3. Verificar o ambiente

```bash
flutter doctor
```

## 4. Instalar as dependências

```bash
flutter pub get
```

## 5. Executar o aplicativo

Inicie um emulador pelo Android Studio ou conecte um dispositivo Android com a depuração USB habilitada.

Execute o comando:

```bash
flutter run
```

## 6. Dados de acesso

- **Usuário:** admin
- **Senha:** 123456

O banco de dados SQLite é criado automaticamente na primeira execução do aplicativo.

## 7. Testar as funcionalidades

- Realizar o login;
- Cadastrar um cliente;
- Cadastrar um produto;
- Registrar uma venda;
- Consultar o histórico de vendas;
- Verificar os indicadores do painel inicial.

## 8. Gerar o APK

```bash
flutter build apk --release
```

O arquivo será gerado no seguinte caminho:

`build/app/outputs/flutter-apk/app-release.apk`

## 9. Instalação direta pelo APK

Também é possível instalar o aplicativo em um dispositivo Android compatível, sem configurar o ambiente de desenvolvimento.

O APK está disponível para download na seção [Releases](https://github.com/corceteemilly-glitch/Projeto-Integrador-UCS/releases).
