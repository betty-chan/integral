// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
import ExportAchieve from '../../../app/controller/achieve';
import ExportGoods from '../../../app/controller/goods';
import ExportGrade from '../../../app/controller/grade';
import ExportHandle from '../../../app/controller/handle';
import ExportLogin from '../../../app/controller/login';
import ExportSorce from '../../../app/controller/sorce';
import ExportTopic from '../../../app/controller/topic';
import ExportUser from '../../../app/controller/user';
import ExportWish from '../../../app/controller/wish';

declare module 'egg' {
  interface IController {
    achieve: ExportAchieve;
    goods: ExportGoods;
    grade: ExportGrade;
    handle: ExportHandle;
    login: ExportLogin;
    sorce: ExportSorce;
    topic: ExportTopic;
    user: ExportUser;
    wish: ExportWish;
  }
}
