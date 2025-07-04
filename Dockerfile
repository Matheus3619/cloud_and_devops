# 1. Imagem Base
# Usamos uma imagem oficial do Python, versão 3.11.
# A tag "-slim" indica uma versão mais leve, ideal para produção.
FROM python:3.12.11-alpine3.22

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
# Copia todos os arquivos do projeto para o diretório de trabalho no contêiner.
COPY . .


EXPOSE 8000
# 5. Comando para Executar a Aplicação
# Executa a aplicação com uvicorn.
# O host "0.0.0.0" permite que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]