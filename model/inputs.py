
from abc import ABC
from dataclasses import dataclass
from typing import Any, Optional


"""

---------- CWL -----------

Input (baseclass)
    # Core

    # Optional



WorkflowInput   
    (WorkflowInputParameter class)
    type: Any
    label: Optional[Any]
    secondaryFiles: Optional[Any]
    streamable: Optional[Any]
    doc: Optional[Any]
    id: Optional[Any]
    format: Optional[Any]
    loadContents: Optional[Any]
    loadListing: Optional[Any]
    default: Optional[Any]
    inputBinding: Optional[Any]
    extension_fields: Optional[Dict[str, Any]]
    loadingOptions: Optional[LoadingOptions]

ProcessInput        
    (CommandInputParameter class)
    (identical to CWL WorkflowInput)

StepInput       
    (WorkflowStepInput class)
    id: Optional[Any]
    source: Optional[Any]
    linkMerge: Optional[Any]
    pickValue: Optional[Any]
    loadContents: Optional[Any]
    loadListing: Optional[Any]
    label: Optional[Any]
    default: Optional[Any]
    valueFrom: Optional[Any]
    extension_fields: Optional[Dict[str, Any]]
    loadingOptions: Optional[LoadingOptions]



--------- Janis ----------

TaskInput  (baseclass)
    # Core

    # Optional


WorkflowInput
    (InputNode class)
    (Note: this is more like a step in other formats because it is a Node)
    wf: Workflow
    node_type: NodeType
    identifier: NodeLabel
    depth: int
    sources: Dict[str, Any]
    datatype: DataType
    default: Any
    value: Any
    doc: Optional[InputDocumentation]

StepInput
    (TInput class)
    tag: str
    intype: DataType
    default: Any
    doc: InputDocumentation

ProcessInput
    (ToolInput class)
    tag: str
    input_type: ParseableType
    separate_value_from_prefix: bool
    prefix_applies_to_all_elements: bool
    presents_as: str
    secondaries_present_as: Dict[str, str]
    separator: str
    localise_file: bool
    default: Any
    value: Any
    prefix: Optional[str]
    position: Optional[int]
    doc: Optional[Union[str, DocumentationMeta]]
    shell_quote: bool


-------- Nextflow --------

TaskInput (baseclass)

WorkflowInput

StepInput

ProcessInput


--------- Galaxy ---------

TaskInput (baseclass)

WorkflowInput

StepInput

ProcessInput



--- Janis ---


    type, symbol
    tuple type(symbol), type(symbol)...
    


abstract class BaseInParam extends BaseParam implements InParam {
    final protected Binding binding     # the variable this entity is bound to 
    protected List<BaseParam> holder    # the list of inputs. this input will add inject itself into the list. 
    final short index                   # the index in the input / output block. just calculated as len(holder)
    final short mapIndex                # nested tuple stuff don't worry.
    protected fromObject                # reference to from object (when the param is created from .from())
    protected bindObject                # reference to bind object (when the param is created from .bind())
    protected owner                     # workflow or process etc 
    private inChannel                   # The channel to which the input value is bound
}

--- galaxy2janis ---

class WorkflowInput:
    tag: str
    name: str
    docstring: str
    is_array: bool
    is_optional: bool
    is_runtime: bool
    datatype: JanisDatatype
    value: Any = None

"""


@dataclass 
class Datatype:
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
class StepInput(Input):
    pass

@dataclass
class ProcessInput(Input):
    pass
