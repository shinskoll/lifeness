from guizero import App, Box, PushButton, ListBox, TextBox

app = App(title="Hellow lord")

filename = ""

def get_file():
    filename = app.select_file()

def checklist():
    listbox.clear()
    lines = entry.value.split("\n")
    for i in lines:
        if i.startswith("#"):
            listbox.append(i)

buttonsBox = Box(app, width="fill", align="top", height=25)
load = PushButton(buttonsBox, text="Load", align="left")
save = PushButton(buttonsBox, text="Save", align="left")
listbox = ListBox(app, items=[], height="fill", align="left", width=100)
entry = TextBox(app, width="fill", height="fill", multiline=True, scrollbar=True)

listbox.when_mouse_enters = checklist
checklist()

app.display()
