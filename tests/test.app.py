import unittest
from app import create_app

class FlaskAppTests(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.client = self.app.test_client()

    def test_new_comment(self):
        response = self.client.post('/api/comment/new', json={
            'email': 'test@example.com',
            'comment': 'This is a test comment.',
            'content_id': 1
        })
        self.assertEqual(response.status_code, 200)
        self.assertIn('SUCCESS', response.json['status'])

    def test_list_comments(self):
        response = self.client.get('/api/comment/list/1')
        self.assertEqual(response.status_code, 200)
        self.assertIsInstance(response.json, list)

if __name__ == '__main__':
    unittest.main()
