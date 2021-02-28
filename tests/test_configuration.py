import unittest
import configuration

class TestService(unittest.TestCase):

    def __init__(self, *args, **kwargs):
        unittest.TestCase.__init__(self, *args, **kwargs)

    def test_get_stage_name(self):
        self.assertEqual(configuration.get_stage_name([configuration.get_branch_name()]), '')

if __name__ == '__main__':
    unittest.main()