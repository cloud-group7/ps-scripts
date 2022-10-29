$bucketname='group7-code-bucket-73h3fdsa'
$stackname='pog'

echo 'Copying Git Repository...'
cd repo

echo 'Applying Arguments...'
(Get-Content ./template.yml).replace('${bucketname}', $bucketname) | Set-Content ./new-template.yml

echo 'Zipping contents...'
Compress-Archive -Path src/* -DestinationPath ./index.zip

echo 'Creating S3 Bucket...'
aws s3api create-bucket --bucket $bucketname --acl public-read

echo 'Creating Bucket Policies...'
aws s3api put-bucket-policy --bucket $bucketname --policy file://bucket-policy.json

echo 'Uploading Code to S3...'
aws s3api put-object --bucket $bucketname --key index.zip --body index.zip
#aws s3api put-object --bucket $bucketname --key openapi.json --body openapi.json

echo 'Creating CloudFormation...'
aws cloudformation create-stack --stack-name $stackname --template-body file://new-template.yml --capabilities CAPABILITY_NAMED_IAM

Start-Sleep -Seconds 45

echo 'Cleaning Up...'
Remove-Item index.zip
Remove-Item new-template.yml

echo 'Fetching Information...'
$l=aws lambda get-function-url-config --function-name Server | ConvertFrom-Json
$url=$l.FunctionUrl

echo 'Done! The server is now live at:'
echo $url

Read-Host -Prompt 'Press Enter to Exit'