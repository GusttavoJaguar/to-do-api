Documentação Técnica: Projeto To-Do API

Autor: Gusttavo Jaguar
Repositório: to-do-api

Visão Geral do Projeto

O projeto To-Do API é uma aplicação backend desenvolvida com o framework Ruby on Rails. O objetivo principal é fornecer uma API RESTful (Application Programming Interface) para gerenciar uma lista de tarefas (To-Do List). Esta API foi projetada para ser consumida por aplicações frontend, como o projeto to-do-frontend (React) ou todo-front-vue (Vue.js).


| Tecnologia | Descrição / Propósito |
| --- | --- |
| **Ruby** | Linguagem de programação principal do projeto. |
| **Ruby on Rails (Rails)** | Framework web utilizado para estruturar a API, gerenciar rotas, controladores e modelos de banco de dados. |
| **PostgreSQL (pg)** | Sistema de gerenciamento de banco de dados relacional (SGBD) utilizado para persistência das tarefas. |
| **Puma** | Servidor web padrão do Rails, responsável por lidar com as requisições HTTP concorrentes. |
| **Rack CORS** | Middleware utilizado para configurar o Cross-Origin Resource Sharing (CORS), permitindo que aplicações frontend em domínios diferentes (ex: `localhost:3000` ou `vercel.app`) façam requisições para a API. |


Arquitetura e Funcionalidades Técnicas

1. API RESTful (Rails API Mode)
A aplicação foi gerada (ou configurada) para atuar exclusivamente como uma API (rails new --api). Isso significa que o Rails não renderiza views HTML (ERB), mas sim responde às requisições com dados estruturados, geralmente no formato JSON. Essa arquitetura separa claramente as responsabilidades entre o backend (dados e lógica de negócios) e o frontend (interface do usuário).
2. Configuração de CORS (Cross-Origin Resource Sharing)
A presença da gem rack-cors no Gemfile é um detalhe técnico crucial. Sem essa configuração, os navegadores modernos bloqueiam requisições AJAX (como as feitas pelo Axios no frontend) de domínios diferentes por motivos de segurança. A configuração do CORS permite que a API especifique quais origens (frontends) têm permissão para acessar seus recursos.
3. Banco de Dados e ORM (Active Record)
O projeto utiliza o PostgreSQL como banco de dados principal, indicando uma escolha robusta para produção. O Active Record (ORM do Rails) é utilizado para mapear as tabelas do banco de dados (ex: tasks ou todos) para classes Ruby (Models), facilitando as operações CRUD (Create, Read, Update, Delete) sem a necessidade de escrever SQL puro.
4. Preparação para Produção (Deploy Moderno)
Assim como no projeto cyblog, este repositório apresenta características de uma aplicação pronta para o mundo real:
•Solid Queue / Solid Cache: A presença dessas gems (introduzidas no Rails 8) indica o uso de soluções modernas e baseadas em banco de dados para filas de background jobs e cache, simplificando a infraestrutura (dispensando Redis ou Memcached em muitos casos).

Nível Técnico (Pleno Iniciante)
Este projeto evidencia competências sólidas em desenvolvimento backend e arquitetura de APIs, alinhando o desenvolvedor ao nível Pleno Iniciante:

•Arquitetura API-First: A compreensão da separação entre frontend e backend (construindo uma API RESTful dedicada) é um marco importante na evolução de um desenvolvedor.
•Configuração de Segurança (CORS): A habilidade de configurar corretamente o CORS demonstra conhecimento sobre como os navegadores e as APIs interagem de forma segura.
•DevOps e Infraestrutura: A configuração do projeto com Docker, Kamal e PostgreSQL revela uma visão abrangente do ciclo de vida da aplicação.

