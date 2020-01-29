from guizero import App, Box, PushButton, ListBox, TextBox
import io

app = App(title="Hellow lord")

filename = ""

def getfile():
    filename = app.select_file(filetypes=[["All files", "*.*"], ["Text documents", "*.txt"]])
    f = open(filename, "r", encoding="utf-8")
    entry.value = f.read()

def savefile():
    filename = app.select_file(save=True)
    with open(filename, 'w') as file:
        file.write(entry.value)

def checklist():
    listbox.clear()
    lines = entry.value.split("\n")
    for i in lines:
        if i.startswith("#"):
            listbox.append(i)

buttonsBox = Box(app, width="fill", align="top", height=25)
load = PushButton(buttonsBox, text="Load", command=getfile, align="left")
save = PushButton(buttonsBox, text="Save", command=savefile, align="left")
listbox = ListBox(app, items=[], height="fill", align="left", width=100)
entry = TextBox(app, width="fill", height="fill", multiline=True, scrollbar=True)

listbox.when_mouse_enters = checklist
checklist()

app.display()
