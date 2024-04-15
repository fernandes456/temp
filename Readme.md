Este é um projeto de exemplo de como fazer uma requisição na API da Marvel. É possível favoritar Alguns dos personagens.
Para rodar o projeto, basta dar o comando Run no Xcode (Command + R), uma vez que o projeto não usa dependências externas.
O projeto tem como arquitetura MVVM com Router.
A TabbarController é o ponto de entrada do app e lá é onde se inicia as demais classes e injeta as dependências (no futuro, isso pode ser desacoplado da TabbarController)
Existe duas classes de repository, uma para network e outra para persistência. O repository de persistência é usado pelo favorite manager para persistir os dados dos heróis favoritos salvos.
Embora aja duas telas na tabas, ambas usam a mesma View Controller. A única diferença está no uso de ViewModels diferentes, mas que implementam um protocol em comum.
As dependências da classe de detalhe do herói são injetadas pelo router.

O projeto não tem paginação, um ponto de melhoria futura.
