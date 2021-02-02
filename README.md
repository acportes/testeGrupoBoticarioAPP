# MicroBlogging - APP - Grupo Boticário

# 1. Sobre o projeto

- Aplicação construída em [Flutter](https://flutter.dev/docs/get-started/install), o que permite rodar tanto em dispositivos Android quanto dispositivos IOS
- Utilização da IDE [Android Studio](https://developer.android.com/studio)
- Utilização do emulador do Iphone 8, disponível no XCode para MacOs.
- Utilização das lib [http](https://pub.dev/packages/http), para realização de requisições HTTP(API).
- Utilização das libs [json_annotation](https://pub.dev/packages/json_annotation) e [json_serializable](https://pub.dev/packages/json_serializable)  para parser de JSON


# 2. Preparação dos Ambientes




## Pré-requisitos

- Dart SDK
- Flutter




# 3. Instalação




- Siga as informações para a instalação do Flutter e do Android Studio de acordo com o sistema operacional [Instalação Flutter](https://flutter.dev/docs/get-started/install)
- Para a execução em um dispositivo Android compatível (ver tópico abaixo para visualizar aparelhos compatíveis), basta copiar o APK, disponível na pasta apk deste projeto, para o dispositivo. Depois, navegue até o diretório onde o APK se encontra e o instale, aceitando todas as permissões.



# 4. Executando o projeto

- A aplicação foi testada em 2 aparelhos distintos, via emuladores
  1 - Iphone 8 (Tela 4.7 Resolução HD)
  2 - One Plus 5 (Tela 5.5 Resolução HD)
  
  OBS: A aplicação é melhor adpatada para o uso no Iphone 8 (Tela 4.7)
 
- Após a instalação e configuração do ambiente, selecione o dispositivo desejado e execute o projeto

- Lista de usuários cadastrados, para a realização do LOGIN :
    Email : luiz_pontes@email.com Senha 1234
    Email : f_prattes@email.com Senha 1234
    Email : luci_fernandes@email.com Senha 1234
    Email : llu_neves@email.com Senha 1234
    Email : lucimara_reis@gmail.com Senha 1234





# 5. Abordagens aplicadas

- O projeto foi construído com o Design Pattern MVC
- O projeto utiliza componentes compartilhados entre a aplicação
- O projeto foi adpatado para dois padrões de telas diferentes (4.7 e 5.5)
- É necessária a permissão de leitura/escrita em memória(disco) pois a aplicação armazena as informações de forma local (Como novos cadastros e posts) 