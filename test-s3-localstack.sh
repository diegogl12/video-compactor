#!/bin/bash

# Carrega variáveis do .env se existir
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Testa se a AWS CLI está instalada
if ! command -v aws &> /dev/null; then
  echo "AWS CLI não encontrada. Instale com: brew install awscli"
  exit 1
fi

# Lista todos os buckets
aws --endpoint-url=http://localhost:4566 s3 ls

# Lista objetos do bucket
aws --endpoint-url=http://localhost:4566 s3 ls s3://$VIDEO_BUCKET_NAME

# Cria arquivo de teste
TEST_FILE="teste.txt"
echo "conteudo de teste" > $TEST_FILE

# Faz upload do arquivo
aws --endpoint-url=http://localhost:4566 s3 cp $TEST_FILE s3://$VIDEO_BUCKET_NAME/

# Lista novamente para conferir upload
aws --endpoint-url=http://localhost:4566 s3 ls s3://$VIDEO_BUCKET_NAME/

# Limpa arquivo de teste
echo "Teste finalizado. Se aparecer o teste.txt no bucket, está funcionando!"
rm $TEST_FILE
