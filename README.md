# Delphi HotKey Edit Component (VCL)

A specialized `TEdit` descendant that allows users to capture and display keyboard shortcuts (e.g., `Ctrl+Shift+F12`). It automatically translates virtual key codes and modifiers into human-readable text while storing the raw values for easy integration with the Windows API.

## 📁 Project Structure

`/`: Contains the component package and installation files.

`Source/`: Contains the `HotKeyEdit.pas` unit.

`Demo/`: A VCL application demonstrating how to capture and retrieve key combinations.

## 🚀 Features

* **Real-time Capture**: Intercepts key combinations and prevents default character input.
* **Localized Key Names**: Uses the WinAPI `GetKeyNameText` to display key names (like "Page Up" or "Bild-auf") based on the user's Windows locale.
* **Automatic Overwrite**: Simplifies the UI by replacing the previous shortcut immediately when a new combination is pressed.
* **Modifier Bitmasks**: Internally maps `TShiftState` to Windows `MOD_` constants (Ctrl, Alt, Shift), making it ready for `RegisterHotKey`.
* **Numpad & Extended Key Support**: Correctly distinguishes between standard digits and Numpad keys, as well as arrow and navigation blocks.

## 🛠 Installation

**Install the Package**
1. Open the provided package file or group.
2. This was developed in **RAD Studio 12/13**, but it should run in any modern version of Delphi or RAD Studio, including the Community Edition.
3. Right-click on the package in the Project Manager.
4. Select **Build**, then **Install**.
5. You will now find the component in the Tool Palette under the **l53n** category.

**Library Path**
Ensure the folder containing your `.dcp` and `.dcu` files is added to your Delphi Library Path (**Tools > Options > IDE > Environment Variables**).

## 📖 Usage Example

The component is designed to be drop-in ready. To retrieve the captured shortcut values for use in your application logic:

```pascal
procedure TFormMain.btnSaveClick(Sender: TObject);
var
  Modifiers: UInt;
  VK: Word;
begin
  // Retrieve the raw values stored in the private section
  HotKeyEdit1.GetKeys(Modifiers, VK);
  
  if VK <> 0 then
    ShowMessage(Format('Modifier Flags: %d, Virtual Key: %d', [Modifiers, VK]));
end;
```

Certainly! Here is the second half of the README, starting from the Component Properties & Methods section, provided in a raw Markdown code block for easy copying.

Markdown
## Component Properties & Methods

| Member | Type | Description |
| :--- | :--- | :--- |
| `GetKeys(out Mod, out VK)` | Method | Returns the `MOD_` flags and the Virtual Key code. |
| `SelectedModifiers` | Property (RO) | The current integer bitmask (e.g., `MOD_CONTROL or MOD_SHIFT`). |
| `SelectedVK` | Property (RO) | The Word value of the Virtual Key (e.g., `VK_F12`). |
| `ReadOnly` | Property | Set to `True` by default to prevent manual text entry. |

## Pros and Cons

**Pros**
* **User Friendly**: Displays "Ctrl + Alt + End" instead of cryptic numeric codes.
* **API Ready**: Returns values that can be passed directly to `RegisterHotKey` or used in `OnMessage` handlers.
* **Clean UI**: Overrides `KeyPress` to suppress Windows "ding" sounds when typing in a Readonly field.

**Cons**
* **VCL Only**: Relies on WinAPI keyboard hooks and messages; not compatible with FireMonkey (FMX).
* **Single Key Focus**: Designed for one combination at a time (overwrites previous entry).

## ⚠️ Important Notes

* **Modifier Only**: The component ignores standalone presses of Ctrl, Shift, or Alt. It waits for a primary key (A-Z, F1-F12, etc.) to complete the combination.
* **Focus**: Because it is a `TEdit` descendant, it must have focus to capture the keystrokes.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

📩 **Contact & Support**

If you have questions, find a bug, or want to suggest a feature for the **HotKey Edit Component**, feel free to reach out:

* **Maintainer:** Antony Danby
* **GitHub:** [@AntonyDanby](https://github.com/antonydanby)  
* **Email:** [info@latitude53north.co.uk](mailto:info@latitude53north.co.uk)  
* **Website:** [latitude53north.co.uk](https://latitude53north.co.uk)

> [!TIP]
> Use the `GetKeys` method result with the `RegisterHotKey` Windows API to create system-wide sho