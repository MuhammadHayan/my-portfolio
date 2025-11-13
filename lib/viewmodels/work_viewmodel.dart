import 'package:flutter/material.dart';
import 'package:portfolio/data/project_model.dart';

class ProjectViewModel extends ChangeNotifier {
  bool _visible = false;

  bool get visible => _visible;

  void onVisibilityChanged(double visibleFraction) {
    if (!_visible && visibleFraction > 0.25) {
      _visible = true;
      notifyListeners();
    }
  }

  final List<ProjectModel> _projects = [
    ProjectModel(
      title: "GS Office",
      image: "assets/images/gs_office.png",
      description: "Client office automation Flutter app",
    ),
    ProjectModel(
      title: "GS Driving School",
      image: "assets/images/gs_office.png",
      description: "Driving school management Flutter app",
    ),
    ProjectModel(
      title: "Tailor Made",
      image: "assets/images/tailor_made.png",
      description: "Custom tailoring management flutter app",
    ),
    ProjectModel(
      title: "No Smoking",
      image: "assets/images/no_smoking.png",
      description: "A flutter app promoting health awareness flutter app",
    ),
    ProjectModel(
      title: "Nutri Planner",
      image: "assets/images/nutri_planner.png",
      description: "Nutrition planner app designed with clean UI",
    ),
    ProjectModel(
      title: "Chef Selecta",
      image: "assets/images/chef_selecta.png",
      description: "Recipe & chef booking Flutter app",
    ),
    ProjectModel(
      title: "CanTrip",
      image: "assets/images/cantrip.png",
      description: "A travel app developed in Flutter",
    ),
    ProjectModel(
      title: "Energy Saving",
      image: "assets/images/energy_saving.png",
      description:
          "Flutter + Arduino app for managing smart displays with sensor integration",
    ),
    ProjectModel(
      title: "Voice Based Train Timetable",
      image: "assets/images/train.png",
      description: "Final Year Project built with Flutter",
    ),
  ];

  List<ProjectModel> get projects => _projects;
}
