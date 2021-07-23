/* indent size: 2 */

module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('t_sorce', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    sorce: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    description: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    status: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    type: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    // toJSON: {
    //   type: DataTypes.VIRTUAL,
    //   get: function () {
    //     var values = app.model.dataValues();
    //     if (values.t_user instanceof Object) {
    //       let keys = Object.keys(values.t_user);
    //       keys.forEach((item) => {
    //         values[item] = item;
    //       })
    //     }
    //     return values;
    //   }
    // }
  }, {
    tableName: 't_sorce',
    timestamps: false,
    // getterMethods: {
    //   toJSON: function () {
    //     var values = app.Sequelize.getDataValue();
    //     if (values.t_user instanceof Object) {
    //       let keys = Object.keys(values.t_user);
    //       keys.forEach((item) => {
    //         values[item] = item;
    //       })
    //     }
    //     return values;
    //   }
    // },
  });

  Model.associate = function () {
  }

  return Model;
};
