//integrate window_to_front into your lib/main.dart
import 'package:flutter/material.dart';
import 'package:github/github.dart';                               // Add this import
//integrate the GitHub client 
import 'github_oauth_credentials.dart';
import 'src/github_login.dart';
import 'package:window_to_front/window_to_front.dart';    // Add this

// integrate GitHubSummary into your lib/main.dart
import 'src/github_summary.dart';                                  // Add this import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        WindowToFront.activate();
        return Scaffold(                                           // Modify from here
          appBar: AppBar(
            title: Text(title),
            elevation: 2,
          ),
          body: GitHubSummary(
            gitHub: _getGitHub(httpClient.credentials.accessToken),
          ),
        );
      },                                                           // to here.
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}

GitHub _getGitHub(String accessToken) {                            // Modify from here
  return GitHub(auth: Authentication.withToken(accessToken));
}                                                                  // to here.