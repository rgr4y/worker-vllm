"""Tests for _convert_env_value_to_field_type, focused on bool|str union handling."""
import sys, os, typing
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))
from engine_args import _convert_env_value_to_field_type

# Type matching hf_token: bool | str | None
BoolStrNone = typing.Union[bool, str, None]
PureBool = bool


def test_bool_str_union_token_stays_string():
    assert _convert_env_value_to_field_type("hf_abc123xyz", "hf_token", BoolStrNone) == "hf_abc123xyz"

def test_bool_str_union_true_becomes_bool():
    assert _convert_env_value_to_field_type("true", "hf_token", BoolStrNone) is True

def test_bool_str_union_false_becomes_bool():
    assert _convert_env_value_to_field_type("false", "hf_token", BoolStrNone) is False

def test_bool_str_union_one_becomes_bool():
    assert _convert_env_value_to_field_type("1", "hf_token", BoolStrNone) is True

def test_bool_str_union_zero_becomes_bool():
    assert _convert_env_value_to_field_type("0", "hf_token", BoolStrNone) is False

def test_bool_str_union_empty_becomes_none():
    assert _convert_env_value_to_field_type("", "hf_token", BoolStrNone) is None

def test_pure_bool_true():
    assert _convert_env_value_to_field_type("true", "enforce_eager", PureBool) is True

def test_pure_bool_false():
    assert _convert_env_value_to_field_type("false", "enforce_eager", PureBool) is False

def test_pure_bool_nonbool_string():
    # Pure bool field: non-boolean string → False (not in true-set)
    assert _convert_env_value_to_field_type("randomstring", "enforce_eager", PureBool) is False
