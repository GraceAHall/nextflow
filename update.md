

## Update 17-08-22

### Last 3 weeks

galaxy2janis available on PyPI <br>
`pip install galaxy2janis`

galaxy2janis github complete <br>
https://github.com/GraceAHall/galaxy2janis

- installation instructions
- sample data
- documentation

<br>

### Current work

Planning janis development
- Internal Model 
- How current tech will be bundled into useable modules
- Deciding which features should stay, which should go
- Myself, Richard and Michael currently involved 

<br>

### Next steps

**Integration of galaxy2janis | janis**
- Interim goal is to contain galaxy2janis within janis
- allows ingestion via `janis` rather than `galaxy2janis`
- potentially can extend the output definition formatting to WDL / CWL translations

<br>

**Janis overhaul**
- Current goal is translation of Nextflow / Galaxy / CWL / WDL
- The janis model needs vast changes to support these specs:
    - More generalised & simplified model
    - Technology properly bundled into modules
- Model changes needed because of janis scope change & development history 
- Design plans underway <br>
https://drive.google.com/file/d/1EZ70ps1zm1L4VOqOeaTeJ0zOP6IfD0k4/view?usp=sharing

<br>

**How development should proceed**

(previous development)
- Janis was built based on CWL 
- Janis <-> CWL ingestion / translation is straightforward (internally quite similar)
- Adding full WDL support required vast changes to core model
- Main reason - WDL had unexpected fundamental differences
- This development style follows the 'agile' methodology, but this doesn't suit our goals.
    - Changing core code base is time-consuming and should be avoided at all costs
    - Do not want vast changes to model each time we add a specification

(current development)
- Our development should consider all 4 languages from beginning to avoid a repeat.
- Model should be a generalisation
- Should be as ***simple*** as possible and built from the most primative entities
- Should be segregated so that core entities do not need to change when a new language is supported as possible




