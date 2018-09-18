#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Adam Casey & Vladimir Zhdanov- CSCI3308 - Lab11

# Andy Sayler
# Summer 2014
# CSCI 3308
# Univerity of Colorado
# Text Processing Module

import unittest
import textproc

class TextprocTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        pass

    @classmethod
    def tearDownClass(cls):
        pass

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_init(self):
        text = "testing123"
        p = textproc.Processor(text)
        self.assertEqual(p.text, text, "'text' does not match input")

    def test_init_error(self):
        # self.failUnlessRaises(textproc.Processor(1))
        with self.assertRaises(TypeError):
            textproc.Processor()

    def test_count(self):
        self.assertEqual(textproc.Processor("hello").count(), 5)
        self.assertEqual(textproc.Processor("testing").count(), 7)

    def test_count_alpha(self):
        self.assertEqual(textproc.Processor("hello12345").count_alpha(), 5)
        self.assertEqual(textproc.Processor("1q2w3e4r5t6y").count_alpha(), 6)

    def test_count_numeric(self):
        self.assertEqual(textproc.Processor("0123hello456").count_numeric(), 7)
        self.assertEqual(textproc.Processor("1q2w3e4r5t6y").count_numeric(), 6)

    def test_count_vowels(self):
        self.assertEqual(textproc.Processor("hello").count_vowels(), 2)
        self.assertEqual(textproc.Processor("aeiouy").count_vowels(), 5)

    def test_is_phonenumber(self):
        self.assertEqual(textproc.Processor("123-456-7890").is_phonenumber(), True)

# Main: Run Test Cases
if __name__ == '__main__':
    unittest.main()


    
