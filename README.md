# AWS-CICD-PIPELINE-WITH-TERRAFORM
<p align="center">
  <img src="https://github.com/awsactivators/AWS-CICD-PIPELINE-WITH-TERRAFORM/blob/master/design.png" width="350" title="design">
</p>

https://github.com/awsactivators/AWS-CICD-PIPELINE-WITH-TERRAFORM/blob/master/design.png?raw=true

This is a DevOps Engineer Project on designing and building infrastructure and pipeline to deploy a simple
Hello World API app on AWS using AWS native tools.

The IaC tool that I made use of for infrastructure provisioning and automation is ‘terraform’. In this
terraform stack I made use of the resource block to provision all the infrastructure, input variable for
parameterizing, and output variable.

AWS Resource/Service I made use of
- The CodePipeline which I used to set up the pipeline integration, has different stages, from the commit
to calling on CodeBuild to perform the build, and deploying them to an ECS cluster and service. In this
resource I also specified the artifactory where the artifact produced by the CodeBuild will be stored, I used
Amazon S3 for that.

- The next AWS service that I leveraged was CodeBuild which basically performs the building of the
application, it uses the buildspec.yaml file to specify the build stages like authenticating to AWS ECR via
docker by ensuring the docker daemon is running. The next build stage is building the docker image and
tagging and then finally pushing the created image to AWS ECR.

- I also leveraged ECS for the deployment of the container, which I made use of the EC2.

- I also used AWS CodeCommit for source control management where terraform apply provisioned the
repository while I manually pushed the codes to CodeCommit for AWS CodePipeline to trigger the
deployment and CodeBuild for the build.

- Another AWS service that I leveraged was S3 for securing the terraform.tfstate file by making sure it's
private and not accessible publicly, dynamo DB for locking the terraform.tfstate file so that one person
can work on it one at a time and VPC for a secure connection.

For containerization, I wrote a simple Hello World application using python and flask libraries. Next, I
created a Dockerfile that specifies how the docker image will be built.

I used a python3.7 base image from AWS ECR to build the image, then specified the working directory,
copied all files in the current directory to the/app directory, also made sure that flask was installed during
the build process along with upgrade/update, and then exposed the container to 5002.

Once the Dockerfile is ready to build the image by making sure all the dependencies are in the same
directory as the Dockerfile, I performed a docker build -t image name command and tagged the image by
using the docker tag image name and repository URL.

Before pushing to the image repository, the docker daemon has to be running that is I must authenticate
into docker by performing AWS ECR login | to docker login.
Once logged in, the image can now be pushed to the repo in this case I used AWS ECR, I used docker push
repo url:tag

To make the image become a container I used docker run command and specified some features like -p
for port - d for detached mode, etc.
