import sys
from unittest import TestCase


class TestContext(TestCase):
    def test_behaviour_context(self):
        sys.stdout.write(str("aaaa2"))

        pass
