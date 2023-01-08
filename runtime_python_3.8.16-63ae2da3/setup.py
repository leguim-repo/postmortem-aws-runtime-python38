"""
Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
"""

from distutils.core import setup, Extension


def main():
    setup(name="rapid_client",
          description="AWS Lambda rapid_client for Python BYOL Runtime",
          ext_modules=[Extension("rapid_client", ["rapid_client.cpp"],
                                 extra_compile_args=['--std=c++11'],
                                 library_dirs=['deps/artifacts/lib'],
                                 libraries=['aws-lambda-runtime', 'curl'],
                                 include_dirs=['deps/artifacts/include']
                                 )]
          )


if __name__ == "__main__":
    main()
