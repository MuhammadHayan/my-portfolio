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
      title: "Voice Based Train Timetable",
      image: "assets/images/train.png",
      description: "Final Year Project built with Flutter",
    ),
    ProjectModel(
      title: "Energy Saving",
      image: "assets/images/energy_saving.png",
      description: "Flutter + Arduino IoT app for monitoring",
    ),
    ProjectModel(
      title: "CanTrip",
      image: "assets/images/cantrip.png",
      description: "A travel app developed in Flutter for client",
    ),
    ProjectModel(
      title: "Nutri Planner",
      image: "assets/images/nutri_planner.png",
      description: "Nutrition planner app designed with clean UI",
    ),
    ProjectModel(
      title: "Chef Selecta",
      image: "assets/images/chef_selecta.png",
      description: "Recipe & chef booking Flutter app for client",
    ),
    ProjectModel(
      title: "Tailor Made",
      image: "assets/images/tailor_made.png",
      description: "Custom tailoring management app for client",
    ),
    ProjectModel(
      title: "No Smoking",
      image: "assets/images/no_smoking.png",
      description: "Flutter app promoting health awareness",
    ),
    ProjectModel(
      title: "GS Driving School",
      image: "assets/images/gs_office.png",
      description: "Driving school management Flutter app",
    ),
    ProjectModel(
      title: "GS Office",
      image: "assets/images/gs_office.png",
      description: "Client office automation Flutter project",
    ),
  ];

  List<ProjectModel> get projects => _projects;
}
