# MVVM-vs-MVC-TableView-Comparison

## Overview

This iOS app demonstrates a simple comparison between the Model-View-Controller (MVC) and Model-View-ViewModel (MVVM) architectural patterns, showcasing their implementation in a reusable UITableView.

## Features

- **MVC Implementation**: The app includes a clear MVC architecture where the data source and cell configuration are handled within the view controller.

- **MVVM Implementation**: An alternative MVVM implementation is provided, illustrating the separation of concerns with a dedicated view model responsible for managing the data.

- **Reusable UITableView**: Both implementations utilize a reusable UITableView, powered by a generic `TableViewDataSource` class, making it adaptable to various scenarios.

## MVVM Benefits

- **Separation of Concerns**: MVVM promotes a clearer separation between data, presentation, and user interaction logic.

- **Testability**: With MVVM, the view model can be easily tested independently of the UI, enhancing the overall testability of the codebase.

- **Reusability**: The MVVM approach, combined with the generic `TableViewDataSource`, enhances the reusability of the UITableView components.

## MVC Characteristics

- **Simplicity**: MVC is known for its simplicity and straightforward structure.

- **Ease of Understanding**: MVC is widely understood and familiar, making it a suitable choice for smaller projects.

## Usage

1. Clone the repository.
2. Open the project in Xcode.
3. Explore the `MVC` and `MVVM` folders to understand the implementation differences.
4. Run the app on a simulator or device to see the patterns in action.


