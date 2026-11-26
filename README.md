# ☕ Java Practice Environment

A simple and reusable Java practice environment for Windows users using **VS Code, PowerShell, and JDK 25**.

With this repository, you don't need to configure Java manually every time. Just clone the repository, run the setup script once, and start practicing Java!

## ✨ Features

- Automatic JDK 25 installation (Eclipse Temurin).
- Automatic Java Extension Pack installation in VS Code.
- Automatic Java environment configuration.
- Simple `run` command to execute Java programs.
- No need to manually compile Java files.
- Compiled files are stored in the `out/` directory.
- Clean and beginner-friendly project structure.

## 📁 Project Structure

```text
java_env/
│
├── YourCodeHere.java   # Write your Java code here
├── setup.ps1           # One-time environment setup
├── run.ps1             # Java compile and run script
├── .gitignore          # Ignore unnecessary files
└── README.md           # Documentation
```

## 🛠️ Requirements

Before starting, make sure you have:

- Windows 10 or Windows 11.
- [Visual Studio Code](https://code.visualstudio.com/) installed.
- [Git](https://git-scm.com/) installed.
- Internet connection.
- Windows PowerShell or VS Code PowerShell terminal.

**Note:** You do not need to install Java manually. The setup script will install JDK 25 automatically using Winget.

---

## 🚀 Installation Guide

Follow these steps in order.

### Step 1: Clone the Repository

Open PowerShell or the VS Code terminal and run:

```powershell
git clone https://github.com/gagukibriya/java_env.git
```

### Step 2: Open the Project Folder

```powershell
cd java_env
```

### Step 3: Allow PowerShell Scripts

Windows may block PowerShell scripts by default.

If you see an error saying that script execution is disabled, run this command:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

When PowerShell asks for confirmation, type:

```text
Y
```

Then press Enter.

**Why is this needed?**

This allows locally created PowerShell scripts to run under the `RemoteSigned` policy for your Windows user account. It does not disable all PowerShell security protections.

### Step 4: Run the Setup Script

Run the following command:

```powershell
.\setup.ps1
```

The setup script will:

1. Check whether Winget is available.
2. Install Eclipse Temurin JDK 25 if needed.
3. Install the Java Extension Pack in VS Code if the `code` command is available.
4. Configure Java environment variables.
5. Add the `run` command to your PowerShell profile.

**Important:** Keep your internet connection active during setup.

### Step 5: Restart the VS Code Terminal

After setup finishes:

1. Close the current VS Code terminal.
2. Open a new terminal.
3. Make sure the terminal is opened inside the `java_env` project folder.

You only need to run the setup script once per Windows user.

---

## ▶️ How to Run Java Code

### Step 1: Open the Java File

Open:

```text
YourCodeHere.java
```

### Step 2: Write Your Java Code

Example:

```java
public class YourCodeHere {
    public static void main(String[] args) {

        System.out.println("Hello, Java!");
        System.out.println("Welcome to Java Practice!");

    }
}
```

### Step 3: Run the Program

Open the VS Code PowerShell terminal and type:

```powershell
run
```

Press Enter.

That's it! Your Java program will compile and execute automatically.

### Example Output

```text
Hello, Java!
Welcome to Java Practice!
```

---

## 📦 Where Are Compiled Files Stored?

When you execute the `run` command, Java creates compiled `.class` files inside the `out/` directory.

```text
java_env/
│
├── YourCodeHere.java
└── out/
    └── YourCodeHere.class
```

You don't need to manage these files manually.

The `out/` directory is included in `.gitignore`, so compiled files will not be uploaded to GitHub.

---

## 💻 Useful Commands

| Command | Purpose |
|---|---|
| `git clone https://github.com/gagukibriya/java_env.git` | Clone the repository |
| `cd java_env` | Enter the project folder |
| `.\setup.ps1` | Run the setup script |
| `run` | Compile and execute Java code |
| `java -version` | Check Java version |
| `javac -version` | Check Java compiler version |
| `Get-Command run` | Check whether the `run` command is available |
| `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` | Allow locally created PowerShell scripts |

---

## 🔧 Troubleshooting

### 1. PowerShell Script Execution Is Disabled

If you see an error like:

```text
running scripts is disabled on this system
```

Run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Then press `Y` and Enter.

### 2. The `run` Command Is Not Recognized

If PowerShell shows:

```text
The term 'run' is not recognized
```

First, reload your PowerShell profile:

```powershell
. $PROFILE
```

Then check:

```powershell
Get-Command run
```

If the command is still unavailable, run the setup script again:

```powershell
.\setup.ps1
```

### 3. Java or Javac Is Not Recognized

Check whether Java is installed:

```powershell
java -version
javac -version
```

If either command is unavailable, run the setup script again and restart the VS Code terminal.

### 4. Compilation Error

Make sure:

- The file name is `YourCodeHere.java`.
- The public class name is `YourCodeHere`.
- Your Java code has no syntax errors.
- Your `main()` method is written correctly.

---

## 🔄 Updating the Repository

To get the latest version of this environment, run:

```powershell
git pull
```

---

## 📌 Important Notes

- Write your Java code only inside `YourCodeHere.java`.
- Do not rename the Java file or its public class.
- Run the `run` command from the `java_env` project directory.
- Run `setup.ps1` only once unless you need to repair your setup.
- You do not need to compile Java manually.

## 👨‍💻 Author

**Kibriya**

GitHub: [@gagukibriya](https://github.com/gagukibriya)

---

⭐ If this repository helps you practice Java, feel free to star the repository!