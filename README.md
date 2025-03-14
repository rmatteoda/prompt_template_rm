# AI Prompt Template Manager

A modern, elegant application built with Elixir and Phoenix LiveView for creating, managing, and running AI prompt templates with dynamic placeholders.

![AI Prompt Template Manager](https://via.placeholder.com/800x400/4f46e5/ffffff?text=AI+Prompt+Template+Manager)

## Features

- **Template Management**: Create, edit, view, and delete prompt templates
- **Dynamic Placeholders**: Use `[[today]]` and `[[model]]` placeholders in your templates
- **Template Processing**: Replace placeholders with actual values when running a template
- **Modern UI**: Clean, responsive interface with intuitive navigation

## Getting Started

### Prerequisites

- Elixir 1.14 or later
- Phoenix 1.7 or later
- PostgreSQL

### Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd prompt_template
   ```

2. Install dependencies:
   ```
   mix setup
   ```

3. Create and migrate your database:
   ```
   mix ecto.setup
   ```

4. Start the Phoenix server:
   ```
   mix phx.server
   ```

5. Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Usage

### Creating Templates

1. Navigate to the templates page
2. Click "New Template"
3. Enter a name and template body
4. Use `[[today]]` to insert the current date
5. Use `[[model]]` to insert a model name when running the template
6. Click "Save Template" to create the template

### Running Templates

1. From the templates list, click "Run" on any template
2. Enter the model name when prompted
3. The system will display the processed template with all placeholders replaced

## Technology Stack

- **Backend**: Elixir, Phoenix Framework, Ecto
- **Frontend**: Phoenix LiveView, Tailwind CSS
- **Database**: PostgreSQL

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with Phoenix Framework
- Designed with Tailwind CSS

---

*Created by [Your Name] for the AI Prompt Template Manager project*
