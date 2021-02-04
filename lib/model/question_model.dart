class QuestionModel {
  String instructions;
  String questionID;
  Data data;
  Solution solution;
  String attachment;
  String solutionStrategies;
  String type;
  String widgetType;

  QuestionModel(
      {this.instructions,
      this.questionID,
      this.data,
      this.solution,
      this.attachment,
      this.solutionStrategies,
      this.type,
      this.widgetType});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    instructions = json['instructions'];
    questionID = json['questionID'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    solution = json['solution'] != null
        ? new Solution.fromJson(json['solution'])
        : null;
    attachment = json['attachment'];
    solutionStrategies = json['solutionStrategies'];
    type = json['type'];
    widgetType = json['widget_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instructions'] = this.instructions;
    data['questionID'] = this.questionID;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.solution != null) {
      data['solution'] = this.solution.toJson();
    }
    data['attachment'] = this.attachment;
    data['solutionStrategies'] = this.solutionStrategies;
    data['type'] = this.type;
    data['widget_type'] = this.widgetType;
    return data;
  }
}

class Data {
  String stimulusMedia;
  Metadata metadata;
  String stimulus;
  List<Options> options;
  int marks;
  String type;

  Data(
      {this.stimulusMedia,
      this.metadata,
      this.stimulus,
      this.options,
      this.marks,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    stimulusMedia = json['stimulus_media'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    stimulus = json['stimulus'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    marks = json['marks'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stimulus_media'] = this.stimulusMedia;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    data['stimulus'] = this.stimulus;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['marks'] = this.marks;
    data['type'] = this.type;
    return data;
  }
}

class Metadata {
  int duration;
  String difficulty;
  DistractorRationale distractorRationale;
  String bloom;
  DistractorRationale acknowledgements;
  String construct;
  bool shuffle;
  int version;
  List<MicroConcept> microConcept;

  Metadata(
      {this.duration,
      this.difficulty,
      this.distractorRationale,
      this.bloom,
      this.acknowledgements,
      this.construct,
      this.shuffle,
      this.version,
      this.microConcept});

  Metadata.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    difficulty = json['difficulty'];
    distractorRationale = json['distractor_rationale'] != null
        ? new DistractorRationale.fromJson(json['distractor_rationale'])
        : null;
    bloom = json['bloom'];
    acknowledgements = json['acknowledgements'] != null
        ? new DistractorRationale.fromJson(json['acknowledgements'])
        : null;
    construct = json['construct'];
    shuffle = json['shuffle'];
    version = json['version'];
    if (json['microConcept'] != null) {
      microConcept = new List<MicroConcept>();
      json['microConcept'].forEach((v) {
        microConcept.add(new MicroConcept.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['difficulty'] = this.difficulty;
    if (this.distractorRationale != null) {
      data['distractor_rationale'] = this.distractorRationale.toJson();
    }
    data['bloom'] = this.bloom;
    if (this.acknowledgements != null) {
      data['acknowledgements'] = this.acknowledgements.toJson();
    }
    data['construct'] = this.construct;
    data['shuffle'] = this.shuffle;
    data['version'] = this.version;
    if (this.microConcept != null) {
      data['microConcept'] = this.microConcept.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistractorRationale {
  String label;
  String audio;

  DistractorRationale({this.label, this.audio});

  DistractorRationale.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['audio'] = this.audio;
    return data;
  }
}

class MicroConcept {
  String id;
  String label;

  MicroConcept({this.id, this.label});

  MicroConcept.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class Options {
  List<Feedback> feedback;
  int score;
  String label;
  Null media;
  int value;
  int isCorrect;

  Options(
      {this.feedback,
      this.score,
      this.label,
      this.media,
      this.value,
      this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    if (json['feedback'] != null) {
      feedback = new List<Feedback>();
      json['feedback'].forEach((v) {
        feedback.add(new Feedback.fromJson(v));
      });
    }
    score = json['score'];
    label = json['label'];
    media = json['media'];
    value = json['value'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedback != null) {
      data['feedback'] = this.feedback.map((v) => v.toJson()).toList();
    }
    data['score'] = this.score;
    data['label'] = this.label;
    data['media'] = this.media;
    data['value'] = this.value;
    data['isCorrect'] = this.isCorrect;
    return data;
  }
}

class Feedback {
  String text;

  Feedback({this.text});

  Feedback.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Solution {
  String answer;
  bool stepNav;
  String type;

  Solution({this.answer, this.stepNav, this.type});

  Solution.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    stepNav = json['step_nav'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['step_nav'] = this.stepNav;
    data['type'] = this.type;
    return data;
  }
}
