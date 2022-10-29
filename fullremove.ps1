$bucketname='group7-code-bucket-73h3fdsa'
$stackname='pog'

echo 'Full Removal of Stack and S3'

echo 'Deleting Stack...'
aws cloudformation delete-stack --stack-name $stackname

echo 'Emptying Bucket...'
aws s3 rm s3://$bucketname --recursive

echo 'Deleting Bucket...'
aws s3api delete-bucket --bucket $bucketname

echo 'Done!'
Read-Host -Prompt 'Press Enter to Exit'