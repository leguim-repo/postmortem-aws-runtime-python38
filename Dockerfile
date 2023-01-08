FROM public.ecr.aws/lambda/python:3.8

# common items
RUN yum -y install mc

# Copy function code
COPY app ${LAMBDA_TASK_ROOT}/app

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.lambda_executor.lambda_executor.handler" ]

