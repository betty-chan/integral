// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
import ExportGrade from '../../../app/controller/grade';
import ExportHandle from '../../../app/controller/handle';
import ExportLogin from '../../../app/controller/login';
import ExportSorce from '../../../app/controller/sorce';
import ExportTopic from '../../../app/controller/topic';
import ExportUser from '../../../app/controller/user';

declare module 'egg' {
  interface IController {
    grade: ExportGrade;
    handle: ExportHandle;
    login: ExportLogin;
    sorce: ExportSorce;
    topic: ExportTopic;
    user: ExportUser;
  }
}
