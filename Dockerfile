FROM public.ecr.aws/lambda/python:3.8

# common items tool to play better
RUN yum -y install mc procps zip

# Copy function code
COPY app ${LAMBDA_TASK_ROOT}/app

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.lambda_executor.lambda_executor.handler" ]

