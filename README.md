Projeto direcionado para o desafio backend-autoforce.

# Additional Stuff

-> A security layer, to prevent script kiddies from messing up our Orders and putting on YouTube.
	Adicionar a gem devise para facilitar a criação do modelo de usuário e a Devise Simple Token para facilitar a utilização de token no lugar de realizar o login incessantemente, limitar o uso dos endpoint somente para os usuários cadastrados. Pode-se configurar a gem attack-cors para limitar o numeros de dominios que podem acessar a API.

->A permission layer, that way we can be sure that each user is only working with their stuff.
	A adição do modelo de usuário permite a adição de um atributo, que pode ser um indicador do nivel de permissão do usuário. Cada requisição relizada pelo usuário, terá uma validação para analisar a permissão do mesmo e permitir ou negar a utilização dos recursos da API.

-> Sometimes people confuses Moto G5 with Moto G5S and we need a way to modify Orders in production.
	Adicionar a ação de atualizar os dados do modelo Order (update order), permitindo a mudança das informações do modelo Order. Se as Orders estiverem em 'closing', a API terá que retornar o estado de 'closing' para 'production'. E negar a atualização das informações de Order para aqueles que já foram envidos ou estão com o status de 'sent'.
	
-> A web UI to control everything directly, without the need of going thought the API.
	Pode-se criar uma UI com a tecnologia React e fazer a UI consumir os dados de um servidor que utilize da tecnologia API GraphQL, tendo o foco maior do servidor de persistir os dados, tendo toda a parte de negócio e de cliente na UI feita em React, que por sua vez terá que utilizar as bibliotecas Apollo e graphql-tag para permitir a manipulação do GraphQL.
	
# O que falto melhorar na minha opinião
	Pelo fato de não saber nada de Rails e de Ruby, tive que aprender tudo sobre eles nessa semana e com a falta de experiência da linguagem, sem dúvidas deve ter várias formas melhores de resolver o desafio, do a forma que propus, só utilizando algumas ferramentas da linguagem. Portanto deveria fazer uma refatoração do código depois de estudar um pouco mais da linguagem. 
	Não entendi se era para pegar os status de Order em real-time, se foi pedido, deveria atualizar o endpoint para permitir a conexão real-time e retornar o status de Orders de forma contínua.
	E por último, melhorar os testes. Fiz poucos testes e teve testes que não sei como fazer, portanto teria que dar uma pesquisada e uma estudada a mais afim de melhorá-los.
 
