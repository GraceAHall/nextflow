


from __future__ import annotations
from abc import ABC
from dataclasses import dataclass
from typing import Any, Optional






@dataclass
class Task(ABC):
    tag: str
    inputs: list[Input]


@dataclass
class Workflow(Task):
    pass


@dataclass
class Process(Task):
    pass




@dataclass
class Input(ABC):
    pass


@dataclass
class WorkflowInput(Input):
    tag: str
    name: str
    datatype: Datatype

    datatype_format: Optional[str]
    value: Optional[Any]
    default: Optional[Any]
    label: Optional[str]
    doc: Optional[str]
    is_array: bool
    is_optional: bool

@dataclass
class ProcessInput(Input):
    pass




@dataclass
class Output(ABC):
    pass


@dataclass
class WorkflowOutput(Output):
    pass


@dataclass
class ProcessOutput(Output):
    pass



@dataclass
class Step:
    pass


@dataclass
class Connection:
    pass


@dataclass
class Operator:
    pass


@dataclass 
class Datatype:
    pass